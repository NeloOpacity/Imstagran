<#import "parts/common.ftl" as c>
<@c.page>
    <#include "parts/security.ftl">

    <div class="row mb-4">
        <div class="col text-left">
            <h2>${username}</h2>
        </div>
        <#if isCurrentUser>
            <div class="col text-right">
                <a href="/user/profileSettings" class="btn btn-dark">Profile Settings</a>
            </div>
        <#else>
            <div class="col text-right">
                <form action="${subscribed?string("/unsubscribe","/subscribe")}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="hidden" name="channel" value="${username}">
                    <input type="submit" class="btn btn-info" value="${subscribed?string("Unsubscribe","Subscribe")}">
                </form>
            </div>
        </#if>
    </div>
    <div class="container mb-5">
        <div class="row">
            <div class="col-sm-2 offset-sm-4 text-left">
                <div class="card">
                    <div class="card-body">
                        <p>Subscriptions: <a href="${username}/subscriptions">${subscriptions?size}</a></p>
                    </div>
                </div>
            </div>
            <div class="col-sm-2 text-right">
                <div class="card">
                    <div class="card-body">
                        <p>Subscribers: <a href="${username}/subscribers">${subscribers?size}</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <#include "parts/messageEdit.ftl">
    <#include "parts/messageList.ftl">
</@c.page>