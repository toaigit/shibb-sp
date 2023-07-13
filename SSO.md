# Quick Overview of SSO SAML
---
## Terminologies:
- Your application is a Service Provider (SP)
- Stanford SSO is the Identity Provider (IDP).
---
## Requirements:
- Your Application and Stanford SSO need to have some understandin agreements.
- SP provides the information to IDP in the form of metadata.xml file.
- This metadata.xml contains the information:
           SP IdentityID, Call-Back URL (ACS points), encrypted certificate
- IDP provides to the SP about their IdentityID, certificate, their login URL. For more information about Stanford's IDP, please see https://uit.stanford.edu/service/saml/idp.

---
## How to register your SP metadata to stanford IDP?
- Using self-service tool spdb.stanford.edu.
- For more information, please visit https://uit.stanford.edu/service/saml/spdb-FAQ
- To register your SP, you need the SP metadata.xml, your support team WG name, and your team email.
---
## What are the list of attributes returned to the SP from IDP?
- For more information, please see https://uit.stanford.edu/service/saml/arp
- If you need additional information (attributes) that is not in the above link, you need to log a ticket to saml team.  This can take about 3 to 5 days.
- By default, idP return an unique identifiers of the user in SAML.  Some vendors want the idp to return sunetID, or sunetID@stanford.edu to the nameID.  In this case, you will need to log a ticket to SAML team after you register your application SP using spdb.stanford.edu.
---
## What if the vendor doesn't support encryption of the SAML response/assertion?
- Stanford SSO requires encryption assertion.  Some vendors doesn't support it (it means they don't have the certificate inside of the metadata.xml), in this case, you need to follow exception request process (https://uit.stanford.edu/service/saml/exception).
---
## How do I obtain the application SP metadata.xml file?
-  You should ask your third party vendor for this information.
-  Some vendors have the UI tool inside the application itself. You just need to follow their document to generate the metadata.xml file.  The tool will also require you to provide the IDP information as mentioned before.
-  Once the SP metadata is generated, you can register this metadata to your IDP.
---
## Examples of the SP metadata.xml file
`<md:EntityDescriptor xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata" entityID="https://mydemo.resourceonline.org/">
  <md:SPSSODescriptor protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
    <md:Extensions>
      <init:RequestInitiator xmlns:init="urn:oasis:names:tc:SAML:profiles:SSO:request-init" Binding="urn:oasis:names:tc:SAML:profiles:SSO:request-init" Location="https://mydemo.resourceonline.org/Shibboleth.sso/Login"/>
    </md:Extensions>
    <md:KeyDescriptor>
      <ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
        <ds:X509Data>
          <ds:X509Certificate>
MIIDHTCCAgWgAwIBAgIUOgHAf3imn046q6I5UqZcc5htXDowDQYJKoZIhvcNAQEF
BQAwJDEiMCAGA1UEAxMZbXlkZW1vLnJlc291cmNlb25saW5lLm9yZzAeFw0yMzA0
MjYwMjA3MjBaFw0zMzA0MjMwMjA3MjBaMCQxIjAgBgNVBAMTGW15ZGVtby5yZXNv
dXJjZW9ubGluZS5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2
gFRB9mr5czoMBF5Y8AswcyZ7JyLZ6VrfwdAJmUmDbBGIVH5Rn1n/2Iqgzb+Xv/sF
9mcD1tEG9Vg6BXwxEunugpS4kEbFAJI8V5Kd/BmcQrQaaMqOR8SJBznQw00jvECV
vFFDb1nerccqrZ9lGI8sbY4u4eDW/egiHCOtQhRdzEDOFt36q6JvOOcAX80HM1uY
1MXnQOXpsjgfWaCLrjUmVHspC/DhDwq1RwAr8VtvRaJT3xq/zEZRbe3mXziN9TbY
ZCbH2yd8oYXB/fL3Nw7Nb1lcq7IzHRU9Qtd2VS9hu9Y5WQLXIvAVIRxuJJET08aL
VvZzaNBltk+Zva7Dy/hd9VijaaZWzFt0JD9KcyW24h6DO1uvmpxcm+SEmRFSMN/l
Do4y5ev50aPPJQsbe4u7z74D709rPWxE68y+S8RS7nTr
          </ds:X509Certificate>
        </ds:X509Data>
      </ds:KeyInfo>
    </md:KeyDescriptor>
    <md:AssertionConsumerService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://mydemo.resourceonline.org/Shibboleth.sso/SAML2/POST" index="0"/>
  </md:SPSSODescriptor>
</md:EntityDescriptor>
`
