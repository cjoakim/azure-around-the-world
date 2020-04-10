#!/bin/bash

source ../env.sh

kubectl describe cert ratings-web-cert --namespace $AKS_NAMESPACE

echo 'done'

# Output:
# Name:         ratings-web-cert
# Namespace:    ratingsapp
# Labels:       <none>
# Annotations:  <none>
# API Version:  cert-manager.io/v1alpha3
# Kind:         Certificate
# Metadata:
#   Creation Timestamp:  2020-04-10T16:24:13Z
#   Generation:          1
#   Owner References:
#     API Version:           extensions/v1beta1
#     Block Owner Deletion:  true
#     Controller:            true
#     Kind:                  Ingress
#     Name:                  ratings-web-ingress
#     UID:                   25cf4878-68bb-4e0c-9bb1-21fdff72d204
#   Resource Version:        251629
#   Self Link:               /apis/cert-manager.io/v1alpha3/namespaces/ratingsapp/certificates/ratings-web-cert
#   UID:                     f33dc4cd-c849-4aaa-9e8c-b8f2f36a5c9f
# Spec:
#   Dns Names:
#     frontend.104-45-188-200.nip.io
#   Issuer Ref:
#     Group:      cert-manager.io
#     Kind:       ClusterIssuer
#     Name:       letsencrypt
#   Secret Name:  ratings-web-cert
# Status:
#   Conditions:
#     Last Transition Time:  2020-04-10T16:24:38Z
#     Message:               Certificate is up to date and has not expired
#     Reason:                Ready
#     Status:                True
#     Type:                  Ready
#   Not After:               2020-07-09T15:24:37Z
# Events:
#   Type    Reason        Age   From          Message
#   ----    ------        ----  ----          -------
#   Normal  GeneratedKey  116s  cert-manager  Generated a new private key
#   Normal  Requested     115s  cert-manager  Created new CertificateRequest resource "ratings-web-cert-2637945814"
#   Normal  Issued        91s   cert-manager  Certificate issued successfully
# done
