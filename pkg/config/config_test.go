package config

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestLoadFromEnv(t *testing.T) {
	globalConfig, err := LoadEnv()
	assert.NoError(t, err)

	assertConfig(t, globalConfig)
}

func assertConfig(t *testing.T, globalConfig *Specification) {
	assert.Equal(t, false, globalConfig.Debug)
	assert.Equal(t, "info", globalConfig.LogLevel)
	assert.Equal(t, "dev", globalConfig.Environment)
	assert.Equal(t, "80", globalConfig.Port)
}