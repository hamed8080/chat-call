//
// Chat+TerminateCall.swift
// Copyright (c) 2022 ChatCall
//
// Created by Hamed Hosseini on 12/16/22

import Foundation
import Chat
import ChatDTO
import ChatCore
import ChatModels

// Request
public extension ChatImplementation {
    /// Terminate the call completely for all the participants at once if you have access to it.
    /// - Parameters:
    ///   - request: The callId of the call to terminate.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func terminateCall(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>? = nil, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .terminateCall, uniqueIdResult: uniqueIdResult, completion: completion)
    }
}
