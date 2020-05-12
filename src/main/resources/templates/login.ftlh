<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as log>

<@common.page>
    <main class="container">
        <h1>Login</h1>
        ${message?ifExists}
        <@log.login "/login" false />
    </main>
</@common.page>
