<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as log>

<@common.page>
    <main class="container">
        <h1>Login</h1>
        <@log.login "/login" />
    </main>
</@common.page>
