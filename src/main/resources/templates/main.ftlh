<#import "parts/common.ftlh" as common>

<@common.page>
    <@common.header admin />
    <main class="container">
        <h1></h1>
        <section class="row">
            <h2></h2>
            <form method="post" enctype="multipart/form-data">
                <div class="form-group row">
                    <input type="text" name="text" class="form-control col s11 validate ${(textError??)?string('invalid', '')}" value="<#if message??>${message.text}</#if>" id="messageInput" placeholder="Enter your message...">
                    <span class="helper-text" data-error="${textError!}" data-success="right"></span>
                    <button class="waves-effect waves-light btn col s1" type="submit"><i class="material-icons">send</i></button>
                </div>
                <div class="form-group row">
                    <input type="text" name="tag" class="form-control col s12 validate ${(tagError??)?string('invalid', '')}" value="<#if message??>${message.tag}</#if>" id="tagInput" placeholder="Enter your tag...">
                    <span class="helper-text" data-error="${tagError!}" data-success="right"></span>
                </div>
                <div class="file-field input-field">
                    <div class="btn">
                        <span>File</span>
                        <input type="file" name="file">
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text" placeholder="Upload file">
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
            </form>
        </section>
        <section class="row">
            <h2></h2>
            <form method="get" action="/main">
                <div class="form-group row">
                    <input type="text" name="filter" class="form-control  col s11" id="filterInput" placeholder="Enter your search request...">
                    <button class="waves-effect waves-light btn col s1" type="submit"><i class="material-icons">search</i></button>
                </div>
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
                        <div class="chip">
                            ${message.tag}
                        </div>
                        <p><i>${message.authorName}</i></p>
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