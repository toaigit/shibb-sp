# Overview SSO SAML
This is a quick overview of SAML SSO
---
## Terminologies:
- Your application is a Service Provider (SP)
- Stanford SSO is a Identity Provider (IDP).
---
## Requirements:
- Your Application and Stanford SSO need to have some agreement information.
- SP provides the information in the form of metadata.xml file.
- This metadata.xml contains the information:
           SP IdentityID, Call-Back URL (ACS points), encrypted certificate
- IDP provides to the SP about their IdentityID, certificate, their login URL.
---
## How to register your SP metadata to stanford IDP?
- Using self-service tool spdb.stanford.edu.
-- https://uit.stanford.edu/service/saml/spdb-FAQ
-- You need the SP metadata.xml, your support team WG name, and your team email.
---
## What are the list of attributes returned to the SP from IDP?
- See https://uit.stanford.edu/service/saml/arp
- If you need additional information (attributes) that is not in the above link, you need to log a ticket to saml team.  This can take about 3 to 5 days.
- By default, idP return an unique identifiers of the user in SAML.  Some vendors want the idp to return sunetID, or sunetID@stanford.edu to the nameID.  In this case, you will need to log a ticket to SAML team after you register your application SP using spdb.stanford.edu.
---
## What if the vendor doesn't support encryption of the SAML response/assertion?
- Stanford SSO requires encryption assertion.  Some vendors doesn't support it (it means they don't have the certificate inside of the metadata.xml), in this case, you need to follow exception request process (https://uit.stanford.edu/service/saml/exception).
---
## How do I obtain the application SP metadata.xml file?
-  You should ask your third party vendor for this information.
-  Some vendors have the UI tool inside the application itself. You just need to follow their document to generate the metadata.xml file.  This tool will also require you to provide the IDP information as mentioned before.


