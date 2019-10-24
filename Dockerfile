FROM norionomura/swiftlint:swift-5.1
LABEL version="3.0.1"
LABEL repository="https://github.com/norio-nomura/action-swiftlint"
LABEL homepage="https://github.com/norio-nomura/action-swiftlint"
LABEL maintainer="Norio Nomura <norio.nomura@gmail.com>"

LABEL "com.github.actions.name"="GitHub Action for SwiftLint"
LABEL "com.github.actions.description"="A tool to enforce Swift style and conventions."
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="orange"

COPY Sources action-swiftlint/Sources
COPY Tests action-swiftlint/Tests
COPY Scripts action-swiftlint/Scripts
COPY Package.swift README.md LICENSE action-swiftlint/

RUN apk --no-cache add jq bash curl git git-lfs && \
    cd action-swiftlint && \
    swift build --configuration release --static-swift-stdlib && \
    mv `swift build --configuration release --static-swift-stdlib --show-bin-path`/action-swiftlint /usr/bin && \
    cd .. && \
    rm -rf action-swiftlint && \
    cd Scripts

ENTRYPOINT ["./git-commit.sh"]
#COPY entrypoint.sh /
#ENTRYPOINT ["/entrypoint.sh"]
