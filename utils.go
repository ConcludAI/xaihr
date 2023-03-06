package xaihr

import (
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"strings"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

func getGrpcConn(host string) (*grpc.ClientConn, error) {
	var opts []grpc.DialOption
	if strings.Contains(host, "https://") {
		host = fmt.Sprintf("%s:443", strings.Replace(host, "https://", "", 1))
	}

	systemRoots, err := x509.SystemCertPool()
	if err != nil {
		return nil, err
	}
	cred := credentials.NewTLS(&tls.Config{
		RootCAs: systemRoots,
	})
	opts = append(opts, grpc.WithTransportCredentials(cred))

	return grpc.Dial(host, opts...)
}
