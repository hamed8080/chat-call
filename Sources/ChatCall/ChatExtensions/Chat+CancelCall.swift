//
// Chat+CancelCall.swift
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
    /// The cancelation of a call when nobody answer the call or somthing different happen.
    /// - Parameters:
    ///   - request: A call that you want to cancel a call.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func cancelCall(_ request: CancelCallRequest, uniqueIdResult: UniqueIdResultType? = nil) {
        prepareToSendAsync(req: request, type: .cancelCall, uniqueIdResult: uniqueIdResult)
    }
}

// Response
extension ChatImplementation {
    func onCancelCall(_ asyncMessage: AsyncMessage) {
        let response: ChatResponse<Call> = asyncMessage.toChatResponse()
        delegate?.chatEvent(event: .call(.callCanceled(response)))
        callbacksManager.invokeAndRemove(response, asyncMessage.chatMessage?.type)
    }

    func onGroupCallCanceled(_ asyncMessage: AsyncMessage) {
        var response: ChatResponse<CancelGroupCall> = asyncMessage.toChatResponse()
        response.result?.callId = response.subjectId
        delegate?.chatEvent(event: .call(.groupCallCanceled(response)))
        callbacksManager.invokeAndRemove(response, asyncMessage.chatMessage?.type)
    }
}
