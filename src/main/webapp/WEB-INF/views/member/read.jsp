<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>
<%--<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>--%>
<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">NORI READ</h1>
                        </div>
                        <form id="form1">
                            <input type="hidden" name="page" value="${pageRequestDTO.page}">
                            <input type="hidden" name="size" value="${pageRequestDTO.size}">

                            <div class="form-group">
                                <%--@declare id="title"--%><label for="title">NORI ID</label>
                                <input type="text" name="mid" class="form-control form-control-user" id="mid" value="<c:out value="${memberDTO.mid}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">NAME</label>
                                <input type="text" name="mname" class="form-control form-control-user" id="mname" value="<c:out value="${memberDTO.mname}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                            <label for="title">ADDRESS</label>
                                <input type="text" name="maddress" class="form-control form-control-user" id="maddress" value="<c:out value="${memberDTO.maddress}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">EMAIL</label>
                                <input type="text" name="memail" class="form-control form-control-user" id="memail" value="<c:out value="${memberDTO.memail}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">PHONE</label>
                                <input type="text" name="mphone" class="form-control form-control-user" id="mphone" value="<c:out value="${memberDTO.mphone}"></c:out>" readonly>
                            </div>
                            <hr>
                            <div>
                                <button type="button" class="btn btn-info btnGoList">LIST</button>
<%--                                <sec:authentication property="principal" var="memberDTO"/>--%>
                                <button type="button" class="btn btn-info btnDel">DELETE</button>
                            </div>
                        </form>
                        <br>
                        <div class="card mb-6 py-3 border-left-info">
                            <div class="replies-title">
                                <h5>Details</h5>
<%--                                <sec:authorize access="hasRole('ROLE_ADMIN')"/>--%>
                                    <span class="badge badge-info addReplyBtn">ADD Detail</span>
                            </div>
                            <hr>
                            <div class="direct-chat-messages">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="actionForm" action="/member/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detail</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" name="replyer" readonly <%--value="<sec:authentication property="principal.mid"/>"--%>>
                <input type="text" name="reply">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-info operBtn">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-lg">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modify/Remove</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="rno">
                <input type="text" name="replyerMod" readonly>
                <input type="text" name="replyMod">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-info btnModReply">Modify</button>
                <button type="button" class="btn btn-danger btnRem">Remove</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
    const actionForm = document.querySelector("#actionForm")
    const form = document.querySelector("#form1")

    document.querySelector(".btnGoList").addEventListener("click", ()=>{actionForm.submit()},false)
    document.querySelector(".btnDel").addEventListener("click", (e)=>{
        e.preventDefault()
        e.stopPropagation()

        form.setAttribute("action","/member/remove")
        form.setAttribute("method","post")
        form.submit()

    },false)
</script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/member-reply.js"></script>

<script>
    function getList(){
        const target=document.querySelector(".direct-chat-messages")
        const mid='${memberDTO.mid}'

        function convertTemp(replyObj){
            const {rno,mid,reply,replyer,replyDate,modDate}={...replyObj}
            const temp=`<div class="direct-chat-msg">
                      <div class="direct-chat-infos clearfix">
                        <span class="direct-chat-name float-left">\${rno} -- \${replyer}</span>
                        <span class="direct-chat-timestamp float-right">\${replyDate}</span>
                      </div>
                      <div class="direct-chat-text" data-rno='\${rno}' data-replyer='\${replyer}'>\${reply}</div>
                    </div>`
            return temp
        }

        getReplyList(mid).then(data=>{
            let str="";
            data.forEach(reply=>{
                str+=convertTemp(reply)
            })
            target.innerHTML=str
        })
    }

    (function () {
        getList()
    })()

    const modalDiv=$("#modal-sm")
    let oper=null

    document.querySelector(".addReplyBtn").addEventListener("click", function (){
        oper='add'
        modalDiv.modal('show')
    },false)

    document.querySelector(".operBtn").addEventListener("click", function (){
        const mid='${memberDTO.mid}'
        const replyer=document.querySelector("input[name='replyer']").value
        const reply=document.querySelector("input[name='reply']").value

        if(oper==='add'){
            const replyObj={mid, replyer, reply}
            //console.log(replyObj)
            addReply(replyObj).then(result=>{
                getList()
                modalDiv.modal('hide')
                document.querySelector("input[name='replyer']").value=""
                document.querySelector("input[name='reply']").value=""
            })
        }
    },false)

    const modModal=$("#modal-lg")
    const modReplyer=document.querySelector("input[name='replyerMod']")
    const modReply=document.querySelector("input[name='replyMod']")
    const modRno=document.querySelector("input[name='rno']")

    document.querySelector(".direct-chat-messages").addEventListener("click",(e)=>{
        const target=e.target
        const mid='${memberDTO.mid}'
        if(target.matches(".direct-chat-text")){
            const rno=target.getAttribute("data-rno")
            const replyer=target.getAttribute("data-replyer")
            const reply=target.innerHTML

            modRno.value=rno
            modReply.value=reply
            modReplyer.value=replyer

            document.querySelector(".btnRem").setAttribute("data-rno", rno)
            modModal.modal('show')
        }
    },false)

    document.querySelector(".btnRem").addEventListener("click",(e)=>{
        const rno=e.target.getAttribute("data-rno")
        removeReply(rno).then(result=>{
            getList()
            modModal.modal("hide")
        })
    },false)

    document.querySelector(".btnModReply").addEventListener("click", (e)=>{
        const replyObj={rno: modRno.value, reply: modReply.value}
        modifyReply(replyObj).then(result=>{
            getList()
            modModal.modal("hide")
        })
    },false)
</script>
</body>
</html>