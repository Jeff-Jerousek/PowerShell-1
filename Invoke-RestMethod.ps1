function Invoke-RestMethod
{
[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=217034')]
param(
    [Microsoft.PowerShell.Commands.WebRequestMethod]
    ${Method},

    [switch]
    ${UseBasicParsing},

    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [uri]
    ${Uri},

    [Microsoft.PowerShell.Commands.WebRequestSession]
    ${WebSession},

    [Alias('SV')]
    [string]
    ${SessionVariable},

    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [switch]
    ${UseDefaultCredentials},

    [ValidateNotNullOrEmpty()]
    [string]
    ${CertificateThumbprint},

    [ValidateNotNull()]
    [System.Security.Cryptography.X509Certificates.X509Certificate]
    ${Certificate},

    [string]
    ${UserAgent},

    [switch]
    ${DisableKeepAlive},

    [int]
    ${TimeoutSec},

    [System.Collections.IDictionary]
    ${Headers},

    [ValidateRange(0, 2147483647)]
    [int]
    ${MaximumRedirection},

    [uri]
    ${Proxy},

    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${ProxyCredential},

    [switch]
    ${ProxyUseDefaultCredentials},

    [Parameter(ValueFromPipeline=$true)]
    [System.Object]
    ${Body},

    [string]
    ${ContentType},

    [ValidateSet('chunked','compress','deflate','gzip','identity')]
    [string]
    ${TransferEncoding},

    [string]
    ${InFile},

    [string]
    ${OutFile},

    [switch]
    ${PassThru},

    [switch]
    ${UTF8})
    
begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Invoke-RestMethod', [System.Management.Automation.CommandTypes]::Cmdlet)
        # Start
        if($PSBoundParameters[‘UTF8’])
        {
            $null = $PSBoundParameters.Remove(‘UTF8’) 
            $scriptCmd = {$res = & $wrappedCmd @PSBoundParameters
                if ($res.GetType().FullName -eq 'System.Xml.XmlDocument')
                {
                    [xml][System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::GetEncoding('ISO-8859-1').GetBytes($res.InnerXml))
                }
                else
                {
                    $res
                }
            }
        }
        else
        {
            $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        }
        # End
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process
{
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end
{
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Invoke-RestMethod
.ForwardHelpCategory Cmdlet

#>
}