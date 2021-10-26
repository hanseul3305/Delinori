package com.noriteo.delinori.qna.mapper;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.qna.domain.QnaReply;
import com.noriteo.delinori.saleboard.domain.Reply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface QnaReplyMapper {

    int insert(QnaReply qnaReply);

    List<QnaReply> getListWithPaging(
            @Param("pageRequestDTO") PageRequestDTO pageRequestDTO,
            @Param("qno") Long qno);

    int delete(Long rno);

    int update(QnaReply qnaReply);

    int getCountByQno(Long qno);

    int replyUpdate(QnaReply qnaReply);
}
