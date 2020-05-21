<#import "parts/common.ftlh" as common>
<#include "parts/security.ftlh">

<@common.page>
    <@common.header admin />
    <main class="container row main-window">
        <h1></h1>
        <section class="row col s4">
            <h2>${userChannel.username}</h2>
            <#if !isCurrentUser>
                <div class="row">
                    <#if isSubscriber>
                        <a class="btn" href="/user/unsubscribe/${userChannel.id}">Unsubscribe</a>
                    <#else>
                        <a class="btn" href="/user/subscribe/${userChannel.id}">Subscribe</a>
                    </#if>
                </div>
            </#if>
            <#if isCurrentUser>
                <#include "parts/messageEdit.ftlh">
            </#if>
        </section>
        <section class="row col s8">
            <div class="col s12 m12 l6">
                <div class="card">
                    <div class="card-content">
                        <span class="card-title">Subscribers</span>
                        <h3><a href="/user/subscribers/${userChannel.id}/list">${subscribersCount}</a></h3>
                    </div>
                </div>
            </div>

            <div class="col s12 m12 l6">
                <div class="card">
                    <div class="card-content">
                        <span class="card-title">Subscriptions</span>
                        <h3><a href="/user/subscriptions/${userChannel.id}/list">${subscriptionsCount}</a></h3>
                    </div>
                </div>
            </div>

            <#include "parts/messhsageList.ftlh">
        </section>
    </main>
</@common.page>