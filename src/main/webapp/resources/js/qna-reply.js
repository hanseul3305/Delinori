const getReplyList = async (qno,page) => {

    const pageValue = page || 1

    const response = await axios.get(`/qna/replies/list/${qno}/${pageValue}`)
    console.log("qno : " + qno)
    console.log("page : " + page)

    console.log(response)

    return response.data
}

async function addReply(obj){

    const respose = await axios.post("/qna/replies",obj) // 비동기 처리 -> 응답오면 respose에 담음
    // console.log('doC',respose)
    return respose.data
}

const removeReply = async (rno) => {
    const respose = await axios.delete(`/qna/replies/${rno}`) // 비동기 처리 -> 응답오면 respose에 담음
    return respose.data
}

const modifyReply = async (reply) => { //reply 데이터를 주면 awit (async 다음은 꼭 await)

    const response = await axios.put(`/qna/replies/${reply.rno}`,reply) //put : 수정해서 다시 집어넣는 것
    return response.data
}
