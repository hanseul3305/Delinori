package com.noriteo.delinori.qna.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.qna.domain.QnaReply;
import com.noriteo.delinori.qna.dto.QnaReplyDTO;
import org.springframework.transaction.annotation.Transactional;

public interface QnaReplyService {

    int add(QnaReplyDTO qnaReplyDTO);

    int addGno(QnaReplyDTO qnaReplyDTO);

//    List<QnaReplyDTO> getRepliesWithQno(Long qno);

    int remove(Long rno);

    int modify(QnaReplyDTO qnaReplyDTO);

    PageResponseDTO<QnaReplyDTO> getRepliesList(PageRequestDTO pageRequestDTO, Long qno);

    default QnaReply dtoToEntity(QnaReplyDTO dto){

        QnaReply qnaReply = QnaReply.builder()
                .rno(dto.getRno())
                .qno(dto.getQno())
                .reply(dto.getReply())
                .replyer(dto.getReplyer())
                .replyDate(dto.getReplyDate())
                .modDate(dto.getModDate())
                .gno(dto.getGno())
                .build();

        return qnaReply;
    }

    default QnaReplyDTO entityToDTO(QnaReply qnaReply){
        QnaReplyDTO qnaReplyDTO = QnaReplyDTO.builder()
                .rno(qnaReply.getRno())
                .qno(qnaReply.getQno())
                .reply(qnaReply.getReply())
                .replyer(qnaReply.getReplyer())
                .replyDate(qnaReply.getReplyDate())
                .modDate(qnaReply.getModDate())
                .gno(qnaReply.getGno())
                .build();

        return qnaReplyDTO;
    }
}
