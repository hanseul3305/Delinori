package com.noriteo.delinori.qna.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.qna.dto.QnaReplyDTO;
import com.noriteo.delinori.qna.mapper.QnaMapper;
import com.noriteo.delinori.qna.mapper.QnaReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class QnaReplyServiceImpl implements QnaReplyService {

    private final QnaReplyMapper qnaReplyMapper;
    private final QnaMapper qnaMapper;

    @Override
    public int add(QnaReplyDTO qnaReplyDTO) {
        int count = qnaReplyMapper.insert(dtoToEntity(qnaReplyDTO));
        qnaMapper.updateReplyCnt(qnaReplyDTO.getQno(),1);

        addGno(qnaReplyDTO);

        return count;
    }

    @Override
    public int addGno(QnaReplyDTO qnaReplyDTO) {
        return qnaReplyMapper.update(dtoToEntity(qnaReplyDTO));
    }

    @Override
    public PageResponseDTO<QnaReplyDTO> getRepliesList(PageRequestDTO pageRequestDTO, Long qno) {

        List<QnaReplyDTO> dtoList = qnaReplyMapper.getListWithPaging(pageRequestDTO, qno).stream()
                .map(qnaReply -> entityToDTO(qnaReply))
                .collect(Collectors.toList());
        int count = qnaReplyMapper.getCountByQno(qno);

        PageResponseDTO<QnaReplyDTO> pageResponseDTO = PageResponseDTO.<QnaReplyDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;
    }

    @Override
    public int remove(Long rno) {
        return qnaReplyMapper.delete(rno);
    }

    @Override
    public int modify(QnaReplyDTO qnaReplyDTO) {
        return qnaReplyMapper.update(dtoToEntity(qnaReplyDTO));
    }
}
