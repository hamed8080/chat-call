# Chat

<h5>Swift Chat Call SDK provides video and audio calling facilities.</h5>

<img src="https://github.com/hamed8080/chat/raw/main/images/icon.png"  width="164" height="164">

## Features

- [x] Simplify access to callkit and automate the process of audio and video calling based on WebRTC.

## Installation

#### Swift Package Manager(SPM) 

Add in `Package.swift` or directly in `Xcode Project dependencies` section:

```swift
.package(url: "https://pubgi.fanapsoft.ir/chat/ios/chat-call.git", .upToNextMinor(from: "1.0.0")),
```

#### [CocoaPods](https://cocoapods.org) 
Because it has conflict with other Pods' names in cocoapods you have to use direct git repo.
Add in `Podfile`:

```ruby
pod "Chat", :git => 'http://pubgi.fanapsoft.ir/chat/ios/chat-call.git', :tag => '1.0.0'
```

## How to use? 

```swift
let asyncConfig = AsyncConfigBuilder()
            .socketAddress("socketAddresss")
            .reconnectCount(Int.max)
            .reconnectOnClose(true)
            .appId("PodChat")
            .serverName("serverName")
            .isDebuggingLogEnabled(false)
            .build()
let chatConfig = ChatConfigBuilder(asyncConfig)
            .token("token")
            .ssoHost("ssoHost")
            .platformHost("platformHost")
            .fileServer("fileServer")
            .enableCache(true)
            .msgTTL(800_000)
            .isDebuggingLogEnabled(true)
            .persistLogsOnServer(true)
            .appGroup("group")
            .sendLogInterval(15)
            .build()
ChatManager.instance.createOrReplaceUserInstance(config: config)
ChatManager.activeInstance?.delegate = self
ChatManager.activeInstance?.connect()
```

## Usage 
```swift
ChatManager.activeInstance?.getThreads(.init(), completion: { response in
    if let response.result {
        // Write your code here.
    }
}
```
<br/>

## [Documentation](https://hamed8080.github.io/chat/documentation/chat)
For more information about how to use Chat SDK visit [Documentation](https://hamed8080.github.io/chat/documentation/chat/) 
<br/>

## [Developer Application](https://github.com/hamed8080/ChatApplication) 
For more example and usage you can use [developer implementation app](https://pubgi.fanapsoft.ir/chat/ios/chatapplication)
<br/>

## Contributing to Chat
Please see the [contributing guide](/CONTRIBUTING.md) for more information.

<!-- Copyright (c) 2021-2022 Apple Inc and the Swift Project authors. All Rights Reserved. -->
