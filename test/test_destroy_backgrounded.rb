require File.join(File.dirname(__FILE__), 'helper')

class TestDestroyBackgrounded < Test::Unit::TestCase
  context 'with non-backgrounded activerecord class' do
    should 'not be backgrounded' do
      assert !Link.destroy_backgrounded?
    end
  end

  context 'with backgrounded activerecord class' do
    should 'be backgrounded' do
      assert Blog.destroy_backgrounded?
    end
  end

  context 'with instance of backgrounded class' do
    setup do
      @blog = Blog.create! :title => 'foo'
    end
    context 'when destroying instance with instance.destroy' do
      subject do
        @blog.destroy
        @blog
      end
      should_not destroy_subject
      should_not trigger_callbacks_for :destroy
      #should schedule_destroy_subject
    end
    context 'when destroying instance with Class.destroy_all' do
      subject do
        Blog.destroy_all :id => @blog.id
        @blog
      end
      should_not destroy_subject
      should_not trigger_callbacks_for :destroy
      #should schedule_destroy_subject
    end
    context 'when destroying instance with instance.destroy_immediate' do
      subject do
        @blog.destroy_immediate
        @blog
      end
      should destroy_subject
    end
  end

  context 'with instance of non backgrounded class' do
    setup do
      @link = Link.create! :name => 'foo'
    end
    context 'when destroying instance with instance.destroy' do
      subject do
        @link.destroy
        @link
      end
      should destroy_subject
    end
    context 'when destroying instance with Class.destroy_all' do
      subject do
        Link.destroy_all :id => @link.id
        @link
      end
      should destroy_subject
      # should_not schedule_destroy_subject
    end
  end

  context 'with nonbackgrounded instance that belongs to backgrounded instance' do
    setup do
      @blog = Blog.create!(:title => 'foo')
      @link = @blog.links.create! :text => 'bar'
    end
    context 'when destroying parent backgrounded instance with destroy' do
      subject do
        @blog.destroy
        @link
      end
      should_not destroy_subject
      should_not trigger_callbacks_for :destroy
      #should_not schedule_destroy_subject
    end
    context 'when destroying parent backgrounded instance with destroy_immediate' do
       subject do
         @blog.destroy_immediate
         @link
       end
       should destroy_subject
     end
  end

end

