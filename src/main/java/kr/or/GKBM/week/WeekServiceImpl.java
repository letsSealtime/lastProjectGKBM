package kr.or.GKBM.week;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.GKBM.vendor.VendorDTO;

@Service
public class WeekServiceImpl implements WeekService {
	
	@Autowired
	WeekDAO dao;
	
	@Override
	public List<WeekDTO> sku_select() {
		
		List<WeekDTO> sku_select = dao.sku_select();
		
		return sku_select;
	}
	
	@Override
	public List<WeekDTO> selectALL(WeekDTO dto) {
		
		dto.setIndexStart((dto.getViewCount() * (dto.getPage() - 1)) + 1);
		dto.setIndexEnd(dto.getPage() * dto.getViewCount());

		List<WeekDTO> select = dao.selectALL(dto);

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
	public List<WeekDTO> select(WeekDTO dto) {
		dto.setIndexStart((dto.getViewCount() * (dto.getPage() - 1)) + 1);
		dto.setIndexEnd(dto.getPage() * dto.getViewCount());

		List<WeekDTO> select = dao.select(dto);

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
	public int insert(WeekDTO dto) {
		
		int insert = dao.insert(dto);
		
		return insert;
	}
	
	@Override
	public int delete(WeekDTO dto) {
		
		int delete = dao.delete(dto);
		
		return delete;
	}
	
	@Override
	public int update(WeekDTO dto) {
		
		int update = dao.update(dto);
		
		return update;
	}

}
