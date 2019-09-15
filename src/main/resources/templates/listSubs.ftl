<#import "parts/common.ftl" as c>

<@c.page>
    <#list subs as sub>
        <h3><a href="/channel/${sub.username}">${sub.username}</a></h3>
    </#list>
</@c.page>