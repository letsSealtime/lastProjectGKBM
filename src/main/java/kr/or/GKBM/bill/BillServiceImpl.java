package kr.or.GKBM.bill;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BillServiceImpl implements BillService {

	@Autowired
	BillDAO dao;

	@Override
	public List<BillDTO> selectALL(BillDTO dto) {

		dto.setIndexStart((dto.getViewCount() * (dto.getPage() - 1)) + 1);
		dto.setIndexEnd(dto.getPage() * dto.getViewCount());

		List<BillDTO> select = dao.selectALL(dto);

		System.out.println((double) dto.getPage());

		double up = Math.round(dto.getPage() / 10);
		double down = Math.floor(dto.getPage() / 10);

		System.out.println("up: " + up);
		System.out.println("down: " + down);

		int page;
		if ((double) dto.getLine() / dto.getViewCount() > 0) {
			page = (dto.getLine() / dto.getViewCount()) + 1;
		} else {
			page = (dto.getLine() / dto.getViewCount());
		}

		if (up == down) {
			up = ((up * 10) + dto.getViewCount());
			down = (down * 10) + 1;
			if (up > page) {
				up = page;
			}
		} else {
			down = (down * 10) + 1;
		}

		dto.setBegin((int) down);
		dto.setEnd((int) up);

		return select;
	}

	@Override
	public List<BillDTO> select(BillDTO dto) {
		dto.setIndexStart((dto.getViewCount() * (dto.getPage() - 1)) + 1);
		dto.setIndexEnd(dto.getPage() * dto.getViewCount());

		List<BillDTO> select = dao.select(dto);

		System.out.println((double) dto.getPage());

		double up = Math.round(dto.getPage() / 10);
		double down = Math.floor(dto.getPage() / 10);

		System.out.println("up: " + up);
		System.out.println("down: " + down);

		int page;
		if ((double) dto.getLine() / dto.getViewCount() > 0) {
			page = (dto.getLine() / dto.getViewCount()) + 1;
		} else {
			page = (dto.getLine() / dto.getViewCount());
		}

		if (up == down) {
			up = ((up * 10) + dto.getViewCount());
			down = (down * 10) + 1;
			if (up > page) {
				up = page;
			}
		} else {
			down = (down * 10) + 1;
		}

		dto.setBegin((int) down);
		dto.setEnd((int) up);

		return select;
	}
	
	@Override
	public int insert(BillDTO dto) {
		
		int insert = dao.insert(dto);
		
		return insert;
	}
	
	@Override
	public int delete(BillDTO dto) {
		
		int delete = dao.delete(dto);
		
		return delete;
	}
	
	@Override
	public int update(BillDTO dto) {
		
		int update = dao.update(dto);
		
		return update;
	}
	
}
