//
// Chat+TerminateCall.swift
// Copyright (c) 2022 ChatCall
//
// Created by Hamed Hosseini on 12/16/22

import Foundation
import Chat
import ChatDTO
import ChatModels

public protocol WebRTCActions {
    var callParticipantsUserRTC: [CallParticipantUserRTC] { get }
    func switchCamera()
    func unmuteCall(_ req: UNMuteCallRequest)
    func muteCall(_ req: MuteCallRequest)
    func toggleSpeaker()
    func reCalculateActiveVideoSessionLimit()
    func turnOffVideoCall(callId: Int)
    func turnOnVideoCall(callId: Int)
    func addCallParticipants(_ callParticipants: [CallParticipant])
}

public protocol CallProtocol: WebRTCActions {
    /// Accept a received call.
    /// - Parameters:
    ///   - request: The request that contains a callId and how do you want to answer the call as an example with audio or video.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func acceptCall(_ request: AcceptCallRequest, uniqueIdResult: UniqueIdResultType?)

    /// List of active call participants during the call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func activeCallParticipants(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?, uniqueIdResult: UniqueIdResultType?)

    /// Add a new participant to a thread during the call.
    /// - Parameters:
    ///   - request: A List of people with userNames or contactIds beside a callId.
    ///   - completion: A list of participants has been added to the current call.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func addCallPartcipant(_ request: AddCallParticipantsRequest, completion: @escaping CompletionType<[CallParticipant]>, uniqueIdResult: UniqueIdResultType?)

    /// To get the status of the call and participants after a disconnect or when you need it.
    /// - Parameters:
    ///   - request: The callId.
    ///   - completion: A created call with details.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func callInquery(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<[CallParticipant]>, uniqueIdResult: UniqueIdResultType?)

    /// A request to start recording a call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: A participant that has started recording which is yourself.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func startRecording(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Participant>, uniqueIdResult: UniqueIdResultType?)

    /// A request to stop recording a call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: A participant that has stopped recording which is yourself.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func stopRecording(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Participant>, uniqueIdResult: UniqueIdResultType?)

    /// List of the call history.
    /// - Parameters:
    ///   - request: The request that contains offset and count and some other filters.
    ///   - completion: List of calls.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func callsHistory(_ request: CallsHistoryRequest, completion: @escaping CompletionType<[Call]>, uniqueIdResult: UniqueIdResultType?)

    /// Send a sticker during the call..
    /// - Parameters:
    ///   - request: The callId and a sticker.
    ///   - completion: Response of the send.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func sendCallSticker(_ request: CallStickerRequest, completion: CompletionType<StickerResponse>?, uniqueIdResult: UniqueIdResultType?)

    /// A list of calls that is currnetly is running and you could join to them.
    /// - Parameters:
    ///   - request: List of threads that you are in and more filters.
    ///   - completion: List of joinable calls.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func getCallsToJoin(_ request: GetJoinCallsRequest, completion: @escaping CompletionType<[Call]>, uniqueIdResult: UniqueIdResultType?)

    /// The cancelation of a call when nobody answer the call or somthing different happen.
    /// - Parameters:
    ///   - request: A call that you want to cancel a call.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func cancelCall(_ request: CancelCallRequest, uniqueIdResult: UniqueIdResultType?)

    /// Mute the voice during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the microphone off.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func muteCall(_ request: MuteCallRequest, completion: CompletionType<[CallParticipant]>?, uniqueIdResult: UniqueIdResultType?)

    /// UNMute the voice during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the microphone on.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func unmuteCall(_ request: UNMuteCallRequest, completion: CompletionType<[CallParticipant]>?, uniqueIdResult: UniqueIdResultType?)

    /// Turn on the camera during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the camera on.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func turnOnVideoCall(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?, uniqueIdResult: UniqueIdResultType?)

    /// Turn off the camera during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the camera off.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func turnOffVideoCall(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?, uniqueIdResult: UniqueIdResultType?)

    /// To terminate a call.
    /// - Parameters:
    ///   - request: A request with a callId to finish the current call.
    ///   - completion: A callId that shows a call has terminated properly.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func endCall(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Int>, uniqueIdResult: UniqueIdResultType?)

    /// Remove a participant from a call if you have access.
    /// - Parameters:
    ///   - request: The request that contains a callId and llist of user to remove from a call.
    ///   - completion: List of removed participants from a call.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func removeCallPartcipant(_ request: RemoveCallParticipantsRequest, completion: @escaping CompletionType<[CallParticipant]>, uniqueIdResult: UniqueIdResultType?)

    /// To renew  a call you could start request it by this method.
    /// - Parameters:
    ///   - request: The callId and list of the participants.
    ///   - completion: A created call with details.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func renewCallRequest(_ request: RenewCallRequest, completion: @escaping CompletionType<CreateCall>, uniqueIdResult: UniqueIdResultType?)

    /// A request that shows some errors has happened on the client side during the call for example maybe the user doesn't have access to the camera when trying to turn it on.
    /// - Parameters:
    ///   - request: The code of the error and a callId.
    ///   - completion: Shows the request has successfully arrived.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func sendCallClientError(_ request: CallClientErrorRequest, completion: @escaping CompletionType<CallError>, uniqueIdResult: UniqueIdResultType?)

    /// Start request a call.
    /// - Parameters:
    ///   - request: The request to how to start the call as an example start call with a threadId.
    ///   - completion: A response that tell you if the call is created and contains a callId and more.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func requestCall(_ request: StartCallRequest, completion: @escaping CompletionType<CreateCall>, uniqueIdResult: UniqueIdResultType?)

    /// Start a group call with list of people or a threadId.
    /// - Parameters:
    ///   - request: A request that contains a list of people or a threadId.
    ///   - completion: A response that tell you if the call is created and contains a callId and more.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func requestGroupCall(_ request: StartCallRequest, completion: @escaping CompletionType<CreateCall>, uniqueIdResult: UniqueIdResultType?)

    /// Terminate the call completely for all the participants at once if you have access to it.
    /// - Parameters:
    ///   - request: The callId of the call to terminate.
    ///   - completion: List of call participants that change during the request.
    ///   - uniqueIdResult: The unique id of request. If you manage the unique id by yourself you should leave this closure blank, otherwise, you must use it if you need to know what response is for what request.
    func terminateCall(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?, uniqueIdResult: UniqueIdResultType?)

    /// Only for previewing the current state of the application in swiftUI.
    func preview(startCall: StartCall)
}

public extension CallProtocol {
    /// Accept a received call.
    /// - Parameters:
    ///   - request: The request that contains a callId and how do you want to answer the call as an example with audio or video.
    func acceptCall(_ request: AcceptCallRequest) {
        acceptCall(request, uniqueIdResult: nil)
    }

    /// List of active call participants during the call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: List of call participants that change during the request.
    func activeCallParticipants(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?) {
        activeCallParticipants(request, completion: completion, uniqueIdResult: nil)
    }

    /// Add a new participant to a thread during the call.
    /// - Parameters:
    ///   - request: A List of people with userNames or contactIds beside a callId.
    ///   - completion: A list of participants has been added to the current call.
    func addCallPartcipant(_ request: AddCallParticipantsRequest, completion: @escaping CompletionType<[CallParticipant]>) {
        addCallPartcipant(request, completion: completion, uniqueIdResult: nil)
    }

    /// To get the status of the call and participants after a disconnect or when you need it.
    /// - Parameters:
    ///   - request: The callId.
    ///   - completion: A created call with details.
    func callInquery(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<[CallParticipant]>) {
        callInquery(request, completion: completion, uniqueIdResult: nil)
    }

    /// A request to start recording a call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: A participant that has started recording which is yourself.
    func startRecording(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Participant>) {
        startRecording(request, completion: completion, uniqueIdResult: nil)
    }

    /// A request to stop recording a call.
    /// - Parameters:
    ///   - request: The callId of the call.
    ///   - completion: A participant that has stopped recording which is yourself.
    func stopRecording(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Participant>) {
        stopRecording(request, completion: completion, uniqueIdResult: nil)
    }

    /// List of the call history.
    /// - Parameters:
    ///   - request: The request that contains offset and count and some other filters.
    ///   - completion: List of calls.
    func callsHistory(_ request: CallsHistoryRequest, completion: @escaping CompletionType<[Call]>) {
        callsHistory(request, completion: completion, uniqueIdResult: nil)
    }

    /// Send a sticker during the call..
    /// - Parameters:
    ///   - request: The callId and a sticker.
    ///   - completion: Response of the send.
    func sendCallSticker(_ request: CallStickerRequest, completion: CompletionType<StickerResponse>?) {
        sendCallSticker(request, completion: completion, uniqueIdResult: nil)
    }

    /// Send a sticker during the call..
    /// - Parameters:
    ///   - request: The callId and a sticker.
    func sendCallSticker(_ request: CallStickerRequest) {
        sendCallSticker(request, completion: nil, uniqueIdResult: nil)
    }

    /// A list of calls that is currnetly is running and you could join to them.
    /// - Parameters:
    ///   - request: List of threads that you are in and more filters.
    ///   - completion: List of joinable calls.
    func getCallsToJoin(_ request: GetJoinCallsRequest, completion: @escaping CompletionType<[Call]>) {
        getCallsToJoin(request, completion: completion, uniqueIdResult: nil)
    }

    /// The cancelation of a call when nobody answer the call or somthing different happen.
    /// - Parameters:
    ///   - request: A call that you want to cancel a call.
    func cancelCall(_ request: CancelCallRequest) {
        cancelCall(request, uniqueIdResult: nil)
    }

    /// Mute the voice during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the microphone off.
    ///   - completion: List of call participants that change during the request.
    func muteCall(_ request: MuteCallRequest, completion: CompletionType<[CallParticipant]>?) {
        muteCall(request, completion: completion, uniqueIdResult: nil)
    }

    /// UNMute the voice during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the microphone on.
    ///   - completion: List of call participants that change during the request.
    func unmuteCall(_ request: UNMuteCallRequest, completion: CompletionType<[CallParticipant]>?) {
        unmuteCall(request, completion: completion, uniqueIdResult: nil)
    }

    /// Turn on the camera during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the camera on.
    ///   - completion: List of call participants that change during the request.
    func turnOnVideoCall(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?) {
        turnOnVideoCall(request, completion: completion, uniqueIdResult: nil)
    }

    /// Turn off the camera during the conversation.
    /// - Parameters:
    ///   - request: The callId that you want to turn the camera off.
    ///   - completion: List of call participants that change during the request.
    func turnOffVideoCall(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?) {
        turnOffVideoCall(request, completion: completion, uniqueIdResult: nil)
    }

    /// To terminate a call.
    /// - Parameters:
    ///   - request: A request with a callId to finish the current call.
    ///   - completion: A callId that shows a call has terminated properly.
    func endCall(_ request: GeneralSubjectIdRequest, completion: @escaping CompletionType<Int>) {
        endCall(request, completion: completion, uniqueIdResult: nil)
    }

    /// Remove a participant from a call if you have access.
    /// - Parameters:
    ///   - request: The request that contains a callId and llist of user to remove from a call.
    ///   - completion: List of removed participants from a call.
    func removeCallPartcipant(_ request: RemoveCallParticipantsRequest, completion: @escaping CompletionType<[CallParticipant]>) {
        removeCallPartcipant(request, completion: completion, uniqueIdResult: nil)
    }

    /// To renew  a call you could start request it by this method.
    /// - Parameters:
    ///   - request: The callId and list of the participants.
    ///   - completion: A created call with details.
    func renewCallRequest(_ request: RenewCallRequest, completion: @escaping CompletionType<CreateCall>) {
        renewCallRequest(request, completion: completion, uniqueIdResult: nil)
    }

    /// A request that shows some errors has happened on the client side during the call for example maybe the user doesn't have access to the camera when trying to turn it on.
    /// - Parameters:
    ///   - request: The code of the error and a callId.
    ///   - completion: Shows the request has successfully arrived.
    func sendCallClientError(_ request: CallClientErrorRequest, completion: @escaping CompletionType<CallError>) {
        sendCallClientError(request, completion: completion, uniqueIdResult: nil)
    }

    /// Start request a call.
    /// - Parameters:
    ///   - request: The request to how to start the call as an example start call with a threadId.
    ///   - completion: A response that tell you if the call is created and contains a callId and more.
    func requestCall(_ request: StartCallRequest, completion: @escaping CompletionType<CreateCall>) {
        requestCall(request, completion: completion, uniqueIdResult: nil)
    }

    /// Start a group call with list of people or a threadId.
    /// - Parameters:
    ///   - request: A request that contains a list of people or a threadId.
    ///   - completion: A response that tell you if the call is created and contains a callId and more.
    func requestGroupCall(_ request: StartCallRequest, completion: @escaping CompletionType<CreateCall>) {
        requestGroupCall(request, completion: completion, uniqueIdResult: nil)
    }

    /// Terminate the call completely for all the participants at once if you have access to it.
    /// - Parameters:
    ///   - request: The callId of the call to terminate.
    ///   - completion: List of call participants that change during the request.
    func terminateCall(_ request: GeneralSubjectIdRequest, completion: CompletionType<[CallParticipant]>?) {
        terminateCall(request, completion: completion, uniqueIdResult: nil)
    }
}

extension ChatImplementation: CallProtocol {}

public extension ChatImplementation {
    var callParticipantsUserRTC: [CallParticipantUserRTC] {
        ChatCall.instance?.webrtc?.callParticipantsUserRTC ?? []
    }

    func switchCamera() {

    }

    func unmuteCall(_ req: ChatDTO.UNMuteCallRequest) {

    }

    func muteCall(_ req: ChatDTO.MuteCallRequest) {

    }

    func toggleSpeaker() {

    }

    func reCalculateActiveVideoSessionLimit() {

    }

    func turnOffVideoCall(callId: Int) {

    }

    func turnOnVideoCall(callId: Int) {

    }

    func addCallParticipants(_ callParticipants: [ChatModels.CallParticipant]) {

    }
}

public extension ChatManager {
    static var call: CallProtocol? {
        activeInstance as? CallProtocol
    }
}
