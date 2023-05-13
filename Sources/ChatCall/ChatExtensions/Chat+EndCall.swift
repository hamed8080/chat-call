//
// Chat+EndCall.swift
// Copyright (c) 2022 ChatCall
//
// Created by Hamed Hosseini on 12/16/22

import Foundation
import Chat
import ChatDTO
import ChatCore
import Async

// Request
public extension ChatImplementation {
    /// To terminate a call.
    /// - Parameters:
    ///   - request: A request with a callId to finish the current call.
    ///   - completion: A callId that shows a call has terminated properly.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func endCall(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Int>, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .endCallRequest, uniqueIdResult: uniqueIdResult, completion: completion)
    }
}

// Response
extension ChatImplementation {
    func onCallEnded(_ asyncMessage: AsyncMessage) {
        var response: ChatResponse<Int> = asyncMessage.toChatResponse()
        ChatCall.instance?.callState = .ended
        response.result = response.subjectId
        delegate?.chatEvent(event: .call(.callEnded(response)))
        callbacksManager.invokeAndRemove(response, asyncMessage.chatMessage?.type)
        ChatCall.instance?.webrtc?.clearResourceAndCloseConnection()
        ChatCall.instance?.webrtc = nil
    }
}
