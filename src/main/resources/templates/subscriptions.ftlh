<#import "parts/common.ftlh" as common>
<#include "parts/security.ftlh">

<@common.page>
    <@common.header admin />
    <main class="container row main-window">
        <h1></h1>
        <section class="row col s12">
            <h2>${userChannel.username}</h2>
            <h3>${type}</h3>
            <ul class="collection">
                <#list users as user>
                    <a href="/user-messages/${user.id}" class="collection-item avatar">
                        <i class="material-icons circle">face</i>
                        <span class="title">${user.getUsername()}</span>
                    </a>
                </#list>
            </ul>
        </section>
    </main>
</@common.page>