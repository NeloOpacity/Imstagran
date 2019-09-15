<#include "security.ftl">
<div class="card-columns">
    <#list messages as msg>
        <div class="card">
            <#if msg.filename??>
                <img src="/img/${msg.filename}" class="card-img-top" alt="">
            </#if>
            <div class="m-2">
                <span>${msg.text}</span>
                <i>#${msg.tag}</i>
            </div>
            <div class="card-footer text-muted">
                <#if msg.authorName!=name>
                    <a href="/channel/${msg.authorName}"><strong>${msg.authorName}</strong></a>
                <#else>
                    <strong>${msg.authorName}</strong>
                </#if>

                <#if isCurrentUser?? && isCurrentUser>
                    <div class="text-right">
                        <a href="" class="btn btn-dark">Edit</a>
                    </div>
                </#if>
            </div>
        </div>
    <#else >
        <p>No messages</p>
    </#list>
</div>