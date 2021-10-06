package com.noriteo.delinori.qna.controller;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.qna.dto.QnaReplyDTO;
import com.noriteo.delinori.qna.service.QnaReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@RestController
@RequestMapping("/qna/replies")
@RequiredArgsConstructor
public class QnaReplyController {

    private final QnaReplyService qnaReplyService;

    @PostMapping("")
    public int add(@RequestBody QnaReplyDTO qnaReplyDTO){

        log.info("==========c reply add===========");
        log.info(qnaReplyDTO);

        return qnaReplyService.add(qnaReplyDTO);
    }


    @GetMapping(value = "/list/{qno}/{page}" , produces = "application/json")
    public ResponseEntity<PageResponseDTO> getList(@PathVariable(name = "qno") Long qno , @PathVariable(name="page") int page){

        log.info("===================c  getQnaReplies================");

        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
                .page(page)
                .size(10)
                .build();

        log.info("=====================================");
        log.info("qno : " + qno);
        log.info("pageRequestDTO : " + pageRequestDTO);

        return new ResponseEntity<>(qnaReplyService.getRepliesList(pageRequestDTO, qno), HttpStatus.OK);
    }

    @DeleteMapping("/{rno}")
    public String remove(@PathVariable(name = "rno") Long rno){
        log.info("========c        replyRemove========");
        log.info(rno);

        qnaReplyService.remove(rno);

        return "success";
    }

    @PutMapping("/{rno}")
    public String modify(@PathVariable(name="rno") Long rno, @RequestBody QnaReplyDTO qnaReplyDTO){
        log.info("========c        replyModify========" + rno);
        log.info(qnaReplyDTO);

        qnaReplyService.modify(qnaReplyDTO);

        return "sucess";
    }
}
