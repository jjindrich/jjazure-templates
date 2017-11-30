# JJ Azure Application Gateway and HTTP/2

## Deploy AppGW with HTTP/2
Use template to deploy Application Gateway.

Create new HTTPS listener and rule for HTTPS manually. Use attached certificates.

## Windows Virtual Machine with HTTP/2
Run Windows2016 server and configure it to enable http/2.
Http/2 is working only on TLS (https) connections.

[How to enable HTTP/2] https://msandbu.wordpress.com/2015/09/04/setting-up-http2-support-on-iis-server-2016-citrix-storefront/

Test https://localhost and check F12
![localhost](media/localhost.png)

Test in browser url running Azure VM
![virtual machine](media/vm.png)

## Test Applicationn Gateway HTTP/2
Test in browser
![application gateway](media/appgw.png)

## Protocol gRPC
[Quickstart for c#] https://grpc.io/docs/quickstart/csharp.html