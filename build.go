package main

import (
	"context"

	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

func NewApp(ctx context.Context, log logrus.FieldLogger) *cobra.Command {
	return &cobra.Command{}
}
