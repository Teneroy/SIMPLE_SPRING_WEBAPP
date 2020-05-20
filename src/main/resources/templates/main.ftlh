<#import "parts/common.ftlh" as common>

<@common.page>
    <@common.header admin />
    <main class="container row main-window">
        <h1></h1>
        <section class="row col s4">
            <h2></h2>
            <form method="post" enctype="multipart/form-data">
                <div class="form-group row">
                    <input type="text" name="text" class="form-control col s10 validate ${(textError??)?string('invalid', '')}" value="<#if message??>${message.text}</#if>" id="messageInput" placeholder="Enter your message...">
                    <span class="helper-text" data-error="${textError!}" data-success="right"></span>
                    <button class="waves-effect waves-light btn col s2" type="submit"><i class="material-icons">send</i></button>
                </div>
                <div class="form-group row">
                    <input type="text" name="tag" class="form-control col s12 validate ${(tagError??)?string('invalid', '')}" value="<#if message??>${message.tag}</#if>" id="tagInput" placeholder="Enter your tag...">
                    <span class="helper-text" data-error="${tagError!}" data-success="right"></span>
                </div>
                <div class="file-field input-field last-form-div row">
                    <div class="btn col s2">
                        <span>File</span>
                        <input type="file" name="file">
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text" placeholder="Upload file">
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
            </form>
            <form method="get" action="/main">
                <div class="form-group row last-form-div">
                    <input type="text" name="filter" class="form-control  col s10" id="filterInput" placeholder="Enter your search request...">
                    <button class="waves-effect waves-light btn col s2" type="submit"><i class="material-icons">search</i></button>
                </div>
            </form>
        </section>
        <section class="row col s8">
            <h2></h2>
            <#list messages as message>
            <div class="col s12 m12 l12">
                <div class="card">
                    <div class="card-content">
                        <span class="card-title">${message.id}</span>
                        <p>${message.text}</p>
                    </div>
                    <div class="card-action">
                        <div class="chip">
                            ${message.tag}
                        </div>
                        <p><a href="/user-messages/${message.author.id}"><i>${message.authorName}</i></a></p>
                    </div>
                    <#if message.filename??>
                        <div class="card-image">
                            <img src="/img/${message.filename}" alt="">
                        </div>
                    </#if>
                </div>
            </div>
            </#list>
        </section>
    </main>
</@common.page>