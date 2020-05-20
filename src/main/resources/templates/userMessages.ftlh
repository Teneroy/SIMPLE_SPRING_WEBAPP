<#import "parts/common.ftlh" as common>

<@common.page>
    <@common.header admin />
    <main class="container row main-window">
        <h1></h1>
        <section class="row col s4">
            <#if isCurrentUser>
                <#include "parts/messageEdit.ftlh">
            </#if>
        </section>
        <section class="row col s8">
            <#include "parts/messhsageList.ftlh">
        </section>
    </main>
</@common.page>