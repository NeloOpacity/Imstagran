<#import "parts/common.ftl" as c>

<@c.page>
    <p>User editor</p>
    <form action="/user" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="hidden" name="userId" value="${user.id}">
        <input type="text" name="username" value="${user.username}">
        <#list roles as role>
            <div>
                <label><input type="checkbox"
                              name="${role}" ${user.roles?seq_contains(role)?string("checked","")}>${role}</label>
            </div>
        </#list>
        <input type="submit" value="SAVE">
    </form>
</@c.page>