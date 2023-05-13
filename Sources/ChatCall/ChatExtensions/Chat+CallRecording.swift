//
// Chat+CallRecording.swift
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
    /// A request to start recording a call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: A participant that has started recording which is yourself.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func startRecording(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Participant>, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .startRecording, uniqueIdResult: uniqueIdResult, completion: completion)
    }

    /// A request to stop recording a call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: A participant that has stopped recording which is yourself.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func stopRecording(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Participant>, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .stopRecording, uniqueIdResult: uniqueIdResult, completion: completion)
    }
}

// Response
extension ChatImplementation {
    func onCallRecordingChanged(_ asyncMessage: AsyncMessage) {
        let response: ChatResponse<Participant> = asyncMessage.toChatResponse()
        delegate?.chatEvent(event: asyncMessage.chatMessage?.type == .startRecording ? .call(.startCallRecording(response)) : .call(.stopCallRecording(response)))
        callbacksManager.invokeAndRemove(response, asyncMessage.chatMessage?.type)
    }
}
