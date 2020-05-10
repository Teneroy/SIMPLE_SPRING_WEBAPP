<#import "parts/common.ftlh" as common>

<@common.page>
    <@common.header />
    <main class="container">
        <h1></h1>
        <section class="row">
            <h2></h2>
            <form method="post">
                <div class="form-group row">
                    <input type="text" name="text" class="form-control col s11" id="messageInput" placeholder="Enter your message...">
                    <button class="waves-effect waves-light btn col s1" type="submit"><i class="material-icons">send</i></button>
                </div>
                <div class="form-group row">
                    <input type="text" name="tag" class="form-control col s12" id="tagInput" placeholder="Enter your tag...">
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
            </form>
        </section>
        <section class="row">
            <h2></h2>
            <form method="post" action="filter">
                <div class="form-group row">
                    <input type="text" name="filter" class="form-control  col s11" id="filterInput" placeholder="Enter your search request...">
                    <button class="waves-effect waves-light btn col s1" type="submit"><i class="material-icons">search</i></button>
                </div>
                <input type="hidden" name="_csrf" value="${ _csrf.token}" />
            </form>
        </section>
        <section class="row">
            <h2>Messages</h2>
            <#list messages as message>
            <div class="col s12 m12 l6">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">${message.id}</span>
                        <p>${message.text}</p>
                    </div>
                    <div class="card-action">
                        <p>${message.tag}</p>
                        <p><i>${message.authorName}</i></p>
                    </div>
                </div>
            </div>
            </#list>
        </section>
    </main>
</@common.page>