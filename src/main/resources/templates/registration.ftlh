<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <main class="container">
        <h1>Registration</h1>
        ${message?ifExists}
        <@login.login "/registration" true />
    </main>
</@common.page>
