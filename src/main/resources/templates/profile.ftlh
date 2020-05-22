<#import "parts/common.ftlh" as common>

<@common.page>
    <@common.header admin />
    <main class="container">
        <h1></h1>
        <h5>${username}</h5>
        ${message?ifExists}
        <form method="post">
            <div class="form-group">
                <label for="inputEmail">Email</label>
                <input id="inputEmail" type="email" name="email" class="form-control validate" />
            </div>
            <div class="form-group">
                <label for="inputPassword">Password</label>
                <input type="password" name="password" class="form-control" id="inputPassword" value="${email!''}" />
            </div>
            <input type="hidden" name="_csrf" value="${ _csrf.token}" />
            <button type="submit" class="waves-effect waves-light btn">Save</button>
        </form>
    </main>
</@common.page>