<#import "parts/common.ftlh" as common>

<@common.page>
    <@common.header "USER" />
    <main class="container">
        <h1></h1>
        <form action="/user" method="post">
            <div class="form-group">
                <label for="inputLogin">User name</label>
                <input type="text" name="username" class="form-control" id="inputLogin" value="${user.username}" />
            </div>
            <div class="form-group">
            <#list roles as role>
                <div>
                    <label><input type="checkbox" name="${role}" ${user.roles ? seq_contains(role) ? string("checked", "")} /><span>${role}</span></label>
                </div>
            </#list>
            </div>
            <input type="hidden" value="${user.id}" name="userId" />
            <input type="hidden" name="_csrf" value="${ _csrf.token}" />
            <button type="submit" class="waves-effect waves-light btn">Save</button>
        </form>
    </main>
</@common.page>