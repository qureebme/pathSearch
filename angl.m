function angle = angl(vec1,vec2)

    cosTheta = dot(vec1,vec2)/(norm(vec1)*norm(vec2));
    angle = acos(cosTheta); % in radian
end

