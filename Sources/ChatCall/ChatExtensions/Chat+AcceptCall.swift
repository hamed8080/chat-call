//
// Chat+AcceptCall.swift
// Copyright (c) 2022 ChatCall
//
// Created by Hamed Hosseini on 12/16/22

import Foundation
import Chat
import ChatDTO
import ChatCore

// Request
public extension ChatImplementation {
    /// Accept a received call.
    /// - Parameters:
    ///   - request: The request that contains a callId and how do you want to answer the call as an example with audio or video.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func acceptCall(_ request: AcceptCallRequest, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .acceptCall, uniqueIdResult: uniqueIdResult)
    }
}
