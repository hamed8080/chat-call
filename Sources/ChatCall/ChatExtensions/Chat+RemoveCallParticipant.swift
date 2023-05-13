//
// Chat+RemoveCallParticipant.swift
// Copyright (c) 2022 ChatCall
//
// Created by Hamed Hosseini on 12/16/22

import Foundation
import Chat
import ChatDTO
import ChatCore
import ChatModels
import Async

// Request
public extension ChatImplementation {
    /// Remove a participant from a call if you have access.
    /// - Parameters:
    ///   - request: The request that contains a callId and llist of user to remove from a call.
    ///   - completion: List of removed participants from a call.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func removeCallPartcipant(_ request: RemoveCallParticipantsRequest, completion: @escaping CompletionType<[CallParticipant]>, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .removeCallParticipant, uniqueIdResult: uniqueIdResult, completion: completion)
    }
}

// Response
extension ChatImplementation {
    func onRemoveCallParticipant(_ asyncMessage: AsyncMessage) {
        let response: ChatResponse<[CallParticipant]> = asyncMessage.toChatResponse()
        delegate?.chatEvent(event: .call(.callParticipantsRemoved(response)))
        callbacksManager.invokeAndRemove(response, asyncMessage.chatMessage?.type)
        response.result?.forEach { callParticipant in
            ChatCall.instance?.webrtc?.removeCallParticipant(callParticipant)
            if callParticipant.userId == userInfo?.id {
                ChatCall.instance?.webrtc?.clearResourceAndCloseConnection()
            }
        }
    }
}
