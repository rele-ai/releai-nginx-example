package main

import (
	"context"
	"crypto/tls"
	"encoding/base64"
	"fmt"
	"time"

	"github.com/rele-ai/rb/integratedapp"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/metadata"
	"google.golang.org/protobuf/types/known/structpb"
)

func getToken() string {
	appId := "***REMOVED***"
	appHash := "***REMOVED***"
	token := base64.StdEncoding.EncodeToString([]byte(fmt.Sprintf("%s:%s", appId, appHash)))

	return fmt.Sprintf("Basic %s", token)
}

func main() {
	creds := credentials.NewTLS(
		&tls.Config{
			InsecureSkipVerify: true,
		},
	)

	conn, err := grpc.Dial(
		"localhost:443",
		grpc.WithTransportCredentials(creds),
		grpc.WithBlock(),
		grpc.WithTimeout(time.Duration(20)*time.Second),
	)

	if err != nil {
		fmt.Errorf("%v", err)
		panic("unable to connect")
	}

	defer conn.Close()

	client := integratedapp.NewIntegratedAppsClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), 60*time.Second)
	defer cancel()

	ctx = metadata.AppendToOutgoingContext(ctx, "Authorization", getToken())

	res, err := client.Notify(
		ctx,
		&integratedapp.NotifyRequest{
			OperationKey: "hello_world",
			Payload: &structpb.Struct{
				Fields: map[string]*structpb.Value{
					"foo": &structpb.Value{
						Kind: &structpb.Value_StringValue{
							StringValue: "bar",
						},
					},
				},
			},
		},
	)

	fmt.Printf("res: %v\n", res)
	fmt.Printf("err: %v\n", err)
}
