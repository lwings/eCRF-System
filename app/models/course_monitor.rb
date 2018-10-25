class CourseMonitor < ActiveRecord::Base
  require 'date'

  belongs_to :patient
  belongs_to :research_group

  def renewByRecord(recordDate)
    curPhase = self.current_phase_seq
    curCourse = self.current_course_seq
    curDay = self.current_day_seq
    curIfRest = self.if_rest
    curRestDay = self.current_rest_seq
    curList=[curPhase,curCourse,curDay,curIfRest,curRestDay]

    scheduleChart=self.research_group.getCourseScheduleChart
  end

  def nextCurList(curList,scheduleChart)
    curPhase = curList[0]-1
    curCourse = curList[1]
    curDay = curList[2]
    curIfRest = curList[3]
    curRestDay = curList[4]
    if !curIfRest #unrest
      curDay+=1
      if curDay>scheduleChart[curPhase][1]
        curDay-=1
        if scheduleChart[curPhase][2]>0
          curIfRest=true
          curRestDay=1
        else
          curDay=1
          curCourse+=1
          if curCourse > scheduleChart[curPhase][0]
            curCourse=1
            if curPhase+=1
              if curPhase>scheduleChart.size()-1
                return [scheduleChart.size(),scheduleChart[scheduleChart.size()-1][0],
                        scheduleChart[scheduleChart.size()-1][1],false,0]
              end
            end
          end
        end
      end
    else #rest
      curRestDay+=1
      if curRestDay>scheduleChart[curPhase][2]
        curRestDay=0
        curIfRest=false
        curDay=1
        curCourse+=1
        if curCourse > scheduleChart[curPhase][0]
          curCourse=1
          if curPhase+=1
            if curPhase>scheduleChart.size()-1
              return [scheduleChart.size(),scheduleChart[scheduleChart.size()-1][0],
                      scheduleChart[scheduleChart.size()-1][1],false,0]
            end
          end
        end
      end
    end
    [curPhase+1,curCourse,curDay,curIfRest,curRestDay]
  end

  def priorCurList(curList,scheduleChart)
    
  end
  # private



  def days_till_now(date)
    date=date.strftime("%Y-%m-%d")
    d1 = Date.parse(date)
    d2 = Date.parse(Time.now.strftime("%Y-%m-%d"))
    (d2 - d1).to_i
  end
end
