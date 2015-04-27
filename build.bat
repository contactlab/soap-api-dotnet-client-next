@ECHO off

ECHO ##############################################
ECHO ### Generating code from the WSDL document ###
ECHO ##############################################

SvcUtil.exe /language:C# https://soapnext.contactlab.it/soap/services?wsdl /namespace:domain.ws.api.contactlab.com,"ContactLabAPIClient.DomainSharedTypes" /namespace:campaign.domain.ws.api.contactlab.com,"ContactLabAPIClient.DomainCampaignTypes" /namespace:http://ws.api.contactlab.com/,"ContactLabAPIClient.ClabService" /out:src\ApiClient.cs

ECHO ########################
ECHO ### Applying license ###
ECHO ########################

copy .\src\ApiClient.cs .\src\ApiClient.cs.tmp
type .\resources\license_header.txt > .\src\ApiClient.cs
type .\src\ApiClient.cs.tmp >> .\src\ApiClient.cs
del .\src\ApiClient.cs.tmp

ECHO #################
ECHO ### Compiling ###
ECHO #################

\Windows\Microsoft.NET\Framework64\v4.0.30319\csc /t:library /out:lib\ApiClient.dll .\src\ApiClient.cs
