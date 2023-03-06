package xaihr

import (
	"context"
	"log"
	"xaihr/types"
	cv "xaihr/xapp_cv_extract"

	"google.golang.org/grpc/metadata"
)

type XaiHr struct {
	key    string
	domain string
}

func NewXaiHr(key, domain string) *XaiHr {
	return &XaiHr{
		key:    key,
		domain: domain,
	}
}

// Constant template id
const TEMPLATE string = "t-01GRTKK23Q0NS5NRPD1HSXHQ3B"

// Public URL for CVExtract
const CV_EXTRACT_ENDPOINT = "https://xapp-cv-extract-5qxdkkqowq-uc.a.run.app"

// Creates a new CVExtraction Job and returns Job ID
func (x XaiHr) CvExtract(ctx context.Context, xapp, id, kind string, blob []byte, hookurl, hookauth *string) (string, error) {
	req := &cv.ToPredict{
		Xapp: &types.XappIdentifier{
			Template: TEMPLATE,
			Xapp:     xapp,
		},
		Id: id,
		Resume: &cv.ToPredict_File{
			File: &cv.File{
				Blob: blob,
				Kind: kind,
			},
		},
		Hook:     hookurl,
		Hookauth: hookauth,
	}

	conn, err := getGrpcConn(CV_EXTRACT_ENDPOINT)
	if err != nil {
		log.Println("Error XaiHr.CvExtract: trying to create Grpc client: ", err.Error())
		return "", err
	}
	client := cv.NewXappCVExtractClient(conn)
	h := map[string]string{
		"x-key":  x.key,
		"x-host": x.domain,
	}
	ctx = metadata.NewOutgoingContext(ctx, metadata.New(h))
	res, err := client.Predict(ctx, req)
	if err != nil {
		log.Println("Error XaiHr.CvExtract: trying to make cvExtraction request: ", err)
		return "", err
	}

	return res.GetJob(), nil
}
