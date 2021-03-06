// Code generated by client-gen. DO NOT EDIT.

package fake

import (
	v1alpha1 "github.com/andrebassi/linkedconfig/pkg/client/clientset/versioned/typed/configuratorcontroller/v1alpha1"
	rest "k8s.io/client-go/rest"
	testing "k8s.io/client-go/testing"
)

type FakeConfiguratorV1alpha1 struct {
	*testing.Fake
}

func (c *FakeConfiguratorV1alpha1) CustomConfigMaps(namespace string) v1alpha1.CustomConfigMapInterface {
	return &FakeCustomConfigMaps{c, namespace}
}

func (c *FakeConfiguratorV1alpha1) CustomSecrets(namespace string) v1alpha1.CustomSecretInterface {
	return &FakeCustomSecrets{c, namespace}
}

// RESTClient returns a RESTClient that is used to communicate
// with API server by this client implementation.
func (c *FakeConfiguratorV1alpha1) RESTClient() rest.Interface {
	var ret *rest.RESTClient
	return ret
}
