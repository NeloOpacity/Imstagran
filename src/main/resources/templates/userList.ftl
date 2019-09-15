<#import "parts/common.ftl" as c>

<@c.page>
    <p>List of users</p>
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
        </tr>
        </thead>
        <#list users as u>
            <tr>
                <td>${u.username}</td>
                <td>
                    <#list u.roles as r>
                        ${r}<#sep>,
                    </#list>
                </td>
                <td>
                    <a href="/user/${u.id}">edit</a>
                </td>
            </tr>
        </#list>
    </table>
</@c.page>