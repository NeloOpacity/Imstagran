<#include "security.ftl">
<#import "login.ftl" as l>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">imstagran</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>

            <#if user?? && name??>
                <li class="nav-item">
                    <a class="nav-link" href="/main">Messages</a>
                </li>

                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/">User List</a>
                    </li>
                </#if>

                <li class="nav-item">
                    <a class="nav-link" href="/channel/${name}">My channel</a>
                </li>
            </#if>
        </ul>

        <#if user??&&name??>
            <div class="navbar-text mr-2">${name}</div>
            <@l.logout/>
            <#else>
                <form action="/login" method="get">
                    <input class="btn btn-primary" type="submit" value="Sign in"/>
                </form>
        </#if>
    </div>
</nav>