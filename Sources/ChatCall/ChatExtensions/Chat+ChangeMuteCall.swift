//
// Chat+ChangeMuteCall.swift
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
    /// Mute the voice during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the microphone off.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func muteCall(_ request: MuteCallRequest, completion: CompletionType<[CallParticipant]>? = nil, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .muteCallParticipant, uniqueIdResult: uniqueIdResult, completion: completion)
        ChatCall.instance?.webrtc?.toggle()
    }

    /// UNMute the voice during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the microphone on.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func unmuteCall(_ request: UNMuteCallRequest, completion: CompletionType<[CallParticipant]>? = nil, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .unmuteCallParticipant, uniqueIdResult: uniqueIdResult, completion: completion)
        ChatCall.instance?.webrtc?.toggle()
    }
}

// Response
extension ChatImplementation {
    func onMuteChanged(_ asyncMessage: AsyncMessage) {
        let response: ChatResponse<[CallParticipant]> = asyncMessage.toChatResponse()
        delegate?.chatEvent(event: asyncMessage.chatMessage?.type == .muteCallParticipant ? .call(.callParticipantMute(response)) : .call(.callParticipantUnmute(response)))
        callbacksManager.invokeAndRemove(response, asyncMessage.chatMessage?.type)
    }
}
