<#import "parts/common.ftlh" as common>

<@common.page>
    <@common.header "USER" />
    <main class="container">
        <h1>List of users</h1>
        <ul class="collection">
        <#list users as user>
            <li class="collection-item avatar">
                <i class="material-icons circle">face</i>
                <span class="title">${user.username}</span>
                <p>Roles: <br>
                    <#list user.roles as role>${role}<#sep>, </#list>
                </p>
                <a href="/user/${user.id}" class="secondary-content"><i class="material-icons">edit</i></a>
            </li>
        </#list>
        </ul>
    </main>
</@common.page>