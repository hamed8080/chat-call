//
// Chat+SendCallClient.swift
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
    /// A request that shows some errors has happened on the client side during the call for example maybe the user doesn't have access to the camera when trying to turn it on.
    /// - Parameters:
    ///   - request: The code of the error and a callId.
    ///   - completion: Shows the request has successfully arrived.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func sendCallClientError(_ request: CallClientErrorRequest, completion: @escaping CompletionType<CallError>, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .callClientErrors, uniqueIdResult: uniqueIdResult, completion: completion)
    }
}

// Response
extension ChatImplementation {
    func onCallError(_ asyncMessage: AsyncMessage) {
        let response: ChatResponse<CallError> = asyncMessage.toChatResponse()
        delegate?.chatEvent(event: .call(.callClientError(response)))
        callbacksManager.invokeAndRemove(response, asyncMessage.chatMessage?.type)
    }
}
