#  Overview of SAML SP with Shibboleth
---
## What is the Apache Shibboleth module?
-  Apache Shibboleth Module is an add-on to apache to protect a resource with SAML iDP SSO.
-  This takes a lot of work out of your application coding to support SAML authentication.
-  This module requires shibd (daemond) running on the server.
-  The apache is used as a proxy server seatting in from of the application servers.
---  
How to configure Apache Shibboleth module?
-   There is two parts of the configurations - the server side shibd, and the apache itself.
---
How to configure shibd?
-   Shibd configuration is under /etc/shibboleth folder.
-   The main configuration files are shibboleth2.xml, attribute-mapping.xml.
-   These configuration files specify the iDP that they will need to talk you, and how to map SAML attributes to the environment variables that you can use in your web application. 
-   see https://stanford.atlassian.net/wiki/spaces/IAMAN/pages/64946231/Shibboleth+SP+QuickStart
---
How to configure apache shibboleth?
-    The main configuration files is the shibd.conf.
-    See the example belows
---
How to protect website with SAML SSO using apache mod_shibb?
-    Once the shibd is configured and started, and the apache's shibd.conf configured, you can protected your resouce as follows:
---
How to generate the SP metadata?
- curl -o mysp-metadata.xml https://hostname/Shibboleth.sso/Metadata
---
Where are the log files?
- /var/log/shibboleth (shibd) can be configured in the /etc/shibboleth/shibd.logger
---
## Sample of the shibboleth2.xml (shibd daemon configuration)
#
```
<ApplicationDefaults
     entityID="https://mydemo.resourceonline.org/"  # <---
     REMOTE_USER="uid eppn">  # <---
     <Sessions
         lifetime="28800"
         timeout="600"
         relayState="ss:mem"
         checkAddress="false"
         handlerSSL="true"
         cookieProps="; path=/; secure; HttpOnly">
      <SSO entityID="https://idp.stanford.edu/">SAML2</SSO>  #<---
      <Logout>Local</Logout>
      <Handler type="MetadataGenerator" Location="/Metadata" signing="true"/>
      <Handler type="Status" Location="/Status" acl="127.0.0.1 ::1"/>
      <Handler type="Session" Location="/Session" showAttributeValues="true"/>
   </Sessions>

   <MetadataProvider
        type="XML"
        uri="https://idp.stanford.edu/metadata.xml"  # <---
        backingFilePath="/var/log/shibboleth/metadata.xml"
        reloadInterval="7200">
   </MetadataProvider>

    <AttributeExtractor
       type="XML"
       validate="true"
       reloadChanges="false"
       path="attribute-map.xml"/>     # <---

    <CredentialResolver
       type="File"
       key="sp-key.pem"               # <---
       certificate="sp-cert.pem"/>    # <---

  </ApplicationDefaults>
```
---
## Sample of the attribute-map.xml (shibd daemon configuration)
```
<Attributes
  xmlns="urn:mace:shibboleth:2.0:attribute-map"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Attribute   name="urn:oid:1.3.6.1.4.1.5923.1.1.1.6" id="eppn">
      <AttributeDecoder xsi:type="ScopedAttributeDecoder"/>
  </Attribute>
  <Attribute    name="urn:oid:1.3.6.1.4.1.5923.1.1.1.9" id="scope-affiliation">
      <AttributeDecoder xsi:type="ScopedAttributeDecoder" caseSensitive="false"/>
  </Attribute>
  <Attribute    name="urn:oid:1.3.6.1.4.1.5923.1.1.1.1" id="unscoped-affiliation">
      <AttributeDecoder xsi:type="StringAttributeDecoder" caseSensitive="false"/>
  </Attribute>   
  <Attribute name="urn:oid:1.3.6.1.4.1.5923.1.1.1.7" id="entitlement"/>
  <Attribute name="urn:oid:0.9.2342.19200300.100.1.1" id="uid"/>
  <Attribute name="urn:mace:dir:attribute-def:suUnivID" id="suUnivID"/>
  <Attribute name="urn:oid:1.3.6.1.4.1.299.11.1.1.1" id="suRegID" />
  <Attribute name="urn:oid:2.16.840.1.113730.3.1.241" id="displayName"/>
  <Attribute name="urn:oid:2.5.4.42" id="givenName"/>
  <Attribute name="urn:oid:2.5.4.4" id="sn"/>
  <Attribute name="urn:oid:2.5.4.3" id="cn"/>
  <Attribute name="urn:oid:0.9.2342.19200300.100.1.3" id="mail"/>
</Attributes>
```
---
## Sample of the shibd.conf (apache-shibd mod)
```
       #  This Apache Shibb hanlder
       <Location /Shibboleth.sso>
           Satisfy Any 
           Allow from all
       </Location>
        
       <IfModule mod_alias.c>
             <Location /shibboleth-sp>
                 Satisfy Any
                 Allow from all
             </Location>
             Alias /shibboleth-sp/main.css /usr/share/shibboleth/main.css
       </IfModule>

        
       # define path /secure
       Alias /secure/ "/var/www/html/secure/"
       <Directory "/var/www/html/secure">
          AllowOverride None
          Options None
          Order allow,deny
          Allow from all
       </Directory>

       # force SSO for any request with /secure/
       <Location /secure>
          AuthType shibboleth
          ShibRequestSetting requireSession 1
          Require valid-user
       </Location>
```

