package main

import (
	"context"

	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

// NewApp builds a new app
func NewApp(ctx context.Context, log logrus.FieldLogger) *cobra.Command {
	return &cobra.Command{}
}
