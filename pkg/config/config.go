package config

import (
	"github.com/kelseyhightower/envconfig"
)

type (
	// Specification defines the possible configuration values
	Specification struct {
		ApplicationName string `default:"awesome-service"`
		Debug           bool   `envconfig:"DEBUG" default:"false"`
		LogLevel        string `envconfig:"LOG_LEVEL" default:"info"`
		DatabaseURI     string `envconfig:"DATABASE_URI"`
		Environment     string `envconfig:"APP_ENVIRONMENT" default:"dev"`
		Port            string `envconfig:"PORT" default:"80"`
	}
)

// LoadEnv loads the configuration from environment variables
func LoadEnv() (*Specification, error) {
	var config Specification
	err := envconfig.Process("", &config)
	if err != nil {
		return nil, err
	}
	return &config, nil
}
