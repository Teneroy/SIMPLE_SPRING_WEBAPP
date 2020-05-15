<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as log>

<@common.page>
    <main class="container">
        <h1>Login</h1>
        <h5>${message!}</h5>
        <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
            Incorrect login data
        </#if>
        <@log.login "/login" false />
    </main>
</@common.page>
