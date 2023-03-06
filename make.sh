#!/bin/bash

PACKAGE="xaihr"
TO_REPLACE='xai_go_package'

mkdir proto

ENUM=$(cat ../proto/enum.proto)
ENUM=$(echo "$ENUM" | sed "s/$TO_REPLACE/"$PACKAGE"/")
echo "$ENUM" > proto/enum.proto
TYPES=$(cat ../proto/types.proto)
TYPES=$(echo "$TYPES" | sed "s/$TO_REPLACE/"$PACKAGE"/")
echo "$TYPES" > proto/types.proto
# SES=$(cat ../proto/session.proto)
# SES=$(echo "$SES" | sed "s/$TO_REPLACE/"$PACKAGE"/")
# echo "$SES" > proto/session.proto

protoc --proto_path=proto --go_out=types --go_opt=paths=source_relative \
    enum.proto types.proto

# SENTRY=$(cat ../proto/sentry.proto)
# SENTRY=$(echo "$SENTRY" | sed "s/$TO_REPLACE/"$PACKAGE"/")
# echo "$SENTRY" > proto/sentry.proto
# protoc --proto_path=proto --go_out=sentry --go_opt=paths=source_relative --go-grpc_out=sentry --go-grpc_opt=paths=source_relative \
#     sentry.proto

# MATRIX=$(cat ../proto/matrix.proto)
# MATRIX=$(echo "$MATRIX" | sed "s/$TO_REPLACE/"$PACKAGE"/")
# echo "$MATRIX" > proto/matrix.proto
# protoc --proto_path=proto --go_out=matrix --go_opt=paths=source_relative --go-grpc_out=matrix --go-grpc_opt=paths=source_relative \
#     matrix.proto

# PANDORA=$(cat ../proto/pandora.proto)
# PANDORA=$(echo "$PANDORA" | sed "s/$TO_REPLACE/"$PACKAGE"/")
# echo "$PANDORA" > proto/pandora.proto
# protoc --proto_path=proto --go_out=pandora --go_opt=paths=source_relative --go-grpc_out=pandora --go-grpc_opt=paths=source_relative \
#     pandora.proto

X_CV_EXTRACT=$(cat ../proto/xapp-cv-extract.proto)
X_CV_EXTRACT=$(echo "$X_CV_EXTRACT" | sed "s/$TO_REPLACE/"$PACKAGE"/")
echo "$X_CV_EXTRACT" > proto/xapp-cv-extract.proto
protoc --proto_path=proto --go_out=xapp_cv_extract --go_opt=paths=source_relative --go-grpc_out=xapp_cv_extract --go-grpc_opt=paths=source_relative \
    xapp-cv-extract.proto

rm -rf proto